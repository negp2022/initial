from flask import Flask, request, jsonify
from src.initial.domain.services import ChatGPTService

app = Flask(__name__)
chatgpt_service = ChatGPTService()


@app.route('/generate', methods=['POST'])
def generate():
    prompt = request.json.get('prompt')
    response = chatgpt_service.generate_response(prompt)
    return jsonify(response)


if __name__ == '__main__':
    app.run()
