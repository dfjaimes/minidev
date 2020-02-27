#!/usr/bin/env python3

"""
Just a simple service built with flask
"""

import logging
from flask import Flask

LOGGER = logging.getLogger("cassbackup")
LOGGER.setLevel(logging.INFO)

# create file handler to log to file
FH = logging.FileHandler('cassbackup.log')
FH.setLevel(logging.INFO)

# create console handler to stream to STDOUT
CH = logging.StreamHandler()
CH.setLevel(logging.INFO)

# Set log formatting
FORMATTER = logging.Formatter(
    '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

FH.setFormatter(FORMATTER)
CH.setFormatter(FORMATTER)

# check if handlers are already present and if so, clear them before adding new
# ones
if LOGGER.hasHandlers():
    LOGGER.handlers.clear()

# add handlers to LOGGER
LOGGER.addHandler(CH)
LOGGER.addHandler(FH)

app = Flask(__name__)
@app.route("/")
def index():
    return "Simple Service Running!"


@app.route("/health")
def health():
    return "Simple Service is healthy"


@app.route("/info")
def info():
    return "INFO: This is a stupid simple flask app"


if __name__ == '__main__':
    LOGGER.debug("Simple Service Starting")
    app.run(host='0.0.0.0', port=8080)
