from flask import Flask, render_template
app = Flask(__name__)

@app.route('/')
def tictactoe():
    return render_template("tictactoe.html")
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug= False)