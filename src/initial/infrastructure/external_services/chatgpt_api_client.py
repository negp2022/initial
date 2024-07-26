import requests
from src.initial.config.settings import Config


class ChatGPTAPIClient:
    BASE_URL = "https://api.openai.com/v1"

    def __init__(self):
        self.api_key = Config.OPENAI_API_KEY
        self.headers = {
            "Content-Type": "application/json",
            "Authorization": f"Bearer {self.api_key}"
        }

    def post(self, endpoint, data):
        url = f"{self.BASE_URL}/{endpoint}"
        response = requests.post(url, headers=self.headers, json=data)
        response.raise_for_status()  # Esto lanzará una excepción si la respuesta contiene un error
        return response.json()
