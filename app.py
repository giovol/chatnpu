from flask import Flask, render_template, request, jsonify, send_file
import os

app = Flask(__name__)

chat_history = []  # List to store chat messages

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/send_message', methods=['POST'])
def send_message():
    user_message = request.form['message']
    response_message = f"You said: {user_message}"  # Simple echo response
    chat_history.append(f"You: {user_message}")
    chat_history.append(f"Bot: {response_message}")
    return jsonify({'response': response_message})

@app.route('/export_chat', methods=['GET'])
def export_chat():
    # Create a text file with the chat history
    with open('chat_history.txt', 'w') as f:
        for message in chat_history:
            f.write(message + '\n')
    return send_file('chat_history.txt', as_attachment=True)

if __name__ == '__main__':
    app.run(debug=True)
