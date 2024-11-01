"""
from flask import Flask, request, jsonify

app = Flask(__name__)

compliments = {
  "general": [
    "You're amazing just the way you are!",
    "Your smile is contagious!",
    "You have a great sense of humor!",
  ],
  "custom": [],  # This list will store user-defined compliments
}

@app.route("/compliment", methods=["GET", "POST"])
def get_compliment():
  if request.method == "GET":
    # Return a random compliment from the general list
    compliment = random.choice(compliments["general"])
    return jsonify({"compliment": compliment})
  elif request.method == "POST":
    # Add user-defined compliment to the custom list
    data = request.json
    new_compliment = data.get("compliment")
    if new_compliment:
      compliments["custom"].append(new_compliment)
      return jsonify({"message": "Compliment added successfully!"})
    else:
      return jsonify({"error": "Invalid request data"}), 400

if __name__ == "__main__":
  app.run(debug=True)
  """