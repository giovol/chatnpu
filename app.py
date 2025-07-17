from flask import Flask, render_template, request, jsonify, send_file 
import logging

app = Flask(__name__)

# Chat history list
chat_history = [] 

app.logger.setLevel(logging.ERROR)

@app.route('/')
def index():
    return render_template('index.html')

# Chat function that calls OpenVINO libraries
def chat(msg):
    return "Hello!"

# POST function that get the user message and return the chatbot message
@app.route('/send_message', methods=['POST'])
def send_message():
    user_message = request.form['message']
    app.logger.info(f"Received message: {user_message}") 
    response_message = f"{chat(user_message)}"
    chat_history.append(f"You: {user_message}")
    chat_history.append(f"Bot: {response_message}")
    return jsonify({'response': response_message})

# Export chat function using a text file
@app.route('/export_chat', methods=['GET'])
def export_chat():
    with open('chat_history.txt', 'w') as f:
        for message in chat_history:
            f.write(message + '\n')
    return send_file('chat_history.txt', as_attachment=True)

if __name__ == '__main__':
    app.run(debug=False)
