import os
import platform
import subprocess
import sys
import requests
from bs4 import BeautifulSoup
import json
import re

def check_ollama_installed():
    """Check if Ollama is installed on the system."""
    if platform.system() == "Windows":
        # Check Windows installation
        return os.path.exists("C:\\Program Files\\Ollama\\ollama.exe")
    else:
        # Check Unix-like systems
        try:
            subprocess.run(["which", "ollama"], capture_output=True, check=True)
            return True
        except subprocess.CalledProcessError:
            return False

def install_ollama():
    """Install Ollama based on the operating system."""
    system = platform.system()
    
    if system == "Windows":
        print("Please install Ollama manually from: https://ollama.ai/download")
        print("After installation, restart this script.")
        sys.exit(1)
    
    elif system == "Darwin" or system == "Linux":
        print("Installing Ollama...")
        try:
            curl_command = "curl https://ollama.ai/install.sh | sh"
            subprocess.run(curl_command, shell=True, check=True)
            print("Ollama installed successfully!")
        except subprocess.CalledProcessError as e:
            print(f"Error installing Ollama: {e}")
            sys.exit(1)

def check_and_pull_model(model_name="llama3.2"):
    """Check if the model exists and pull it if not."""
    try:
        import ollama
        
        # Check if model exists
        try:
            ollama.show(model_name)
            print(f"{model_name} model already exists.")
        except:
            print(f"Pulling {model_name} model...")
            ollama.pull(model_name)
            print(f"{model_name} model downloaded successfully!")
    except Exception as e:
        print(f"Error handling model: {e}")
        sys.exit(1)

def extract_website_content(url):
    """Extract title and main content from a website."""
    try:
        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'}
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        
        soup = BeautifulSoup(response.text, 'html.parser')
        
        # Remove unwanted elements
        for element in soup(['script', 'style', 'img', 'input', 'header', 'footer', 'nav']):
            element.decompose()
        
        # Get title
        title = soup.title.string if soup.title else ""
        
        # Get main content
        text_content = soup.get_text(separator=' ', strip=True)
        
        # Clean up the text
        text_content = re.sub(r'\s+', ' ', text_content)
        
        return title, text_content
    except Exception as e:
        print(f"Error fetching website content: {e}")
        return None, None

def create_chat_messages(title, content):
    """Create the initial chat messages with website content."""
    return [
        {
            "role": "system",
            "content": "You are an assistant that analyzes the contents of a website and provides and answers relevant questions, ignoring text that might be navigation-related"
        },
        {
            "role": "user",
            "content": f"The contents of this website is as follows;\nTitle: {title}\nContent: {content}\nPlease provide a short single paragraph summary of this website"
        }
    ]

def main():
    # Check and install Ollama if necessary
    if not check_ollama_installed():
        print("Ollama is not installed. Installing now...")
        install_ollama()
    
    MODEL="llama3.2"
    # Check and pull the model
    check_and_pull_model(MODEL)
    
    # Import ollama after ensuring installation
    import ollama
    
    # Get website URL from user
    url = input("Please enter the website URL to analyze: ")
    title, content = extract_website_content(url)
    
    if not title and not content:
        print("Failed to extract website content. Exiting...")
        return
    
    # Create initial messages and get summary
    messages = create_chat_messages(title, content)
    
    # Get initial summary
    response = ollama.chat(model=MODEL, messages=messages)
    print("\nWebsite Summary:")
    print(response['message']['content'])
    print("\nYou can now ask questions about the website content. Type 'exit' to quit.")
    
    # Interactive chat loop
    while True:
        user_input = input("\nYour question: ").strip()
        
        if user_input.lower() == 'exit':
            print("Goodbye!")
            break
        
        # Add user question to messages
        messages.append({"role": "user", "content": user_input})
        
        # Get response from Ollama
        response = ollama.chat(model=MODEL, messages=messages)
        
        # Print response
        print("\nAssistant:", response['message']['content'])
        
        # Add assistant's response to messages for context
        messages.append(response['message'])

if __name__ == "__main__":
    main()
