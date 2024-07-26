from src.initial.domain.services import ChatGPTService


def main():
    service = ChatGPTService()
    prompt = "Escribe un poema de no más de 100 palabras sobre el amanecer."
    response = service.generate_response(prompt)
    print(response['choices'][0]['text'])


if __name__ == "__main__":
    main()
