from src.initial.infrastructure.external_services.chatgpt_api_client import ChatGPTAPIClient


class ChatGPTService:
    def __init__(self):
        self.client = ChatGPTAPIClient()

    def generate_response(self, prompt, max_tokens=150):
        data = {
            "model": "gpt-3.5-turbo-instruct",
            #"gpt-3.5-turbo-instruct-0914"
            "prompt": prompt,
            "max_tokens": max_tokens
        }
        return self.client.post("completions", data)
