from flask import Flask, request, jsonify
import os

app = Flask(__name__)

log_file_path = "logs/app.log"

@app.route("/", methods=["GET"])
def home():
    return "Welcome to the custom app"

@app.route("/status", methods=["GET"])
def status():
    return jsonify({"status": "ok"})

@app.route("/log", methods=["POST"])
def log_message():
    data = request.get_json()
    message = data.get("message")
    
    if message:
        with open(log_file_path, "a") as log_file:
            log_file.write(message + "\n")
        return jsonify({"message": "Log saved successfully"}), 201
    else:
        return jsonify({"error": "Message is required"}), 400

@app.route("/logs", methods=["GET"])
def get_logs():
    if os.path.exists(log_file_path):
        with open(log_file_path, "r") as log_file:
            logs = log_file.read()
        return logs if logs else "No logs found."
    else:
        return "Log file does not exist.", 404

if __name__ == "__main__":
    os.makedirs(os.path.dirname(log_file_path), exist_ok=True)
    app.run(debug=True, host='0.0.0.0', port=5000)

