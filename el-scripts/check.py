import json
import requests
from requests.auth import HTTPBasicAuth
from argparse import ArgumentParser

"""
***** Definitions *****
"""


def assert_response_code_is_200(response_object):
    assert (response_object.status_code == 200), "Response code from electrum api is not 200! Actual code is " + str(
        response_object.status_code)


"""
***** END Definitions *****
"""

"""
***** Arguments ***** 
"""
parser = ArgumentParser()
parser.add_argument("-u", "--url", dest="url",
                    help="request url", required=True)

parser.add_argument("-l", "--login", dest="login",
                    help="Basic Auth login", required=True)

parser.add_argument("-p", "--pwd", dest="pwd",
                    help="Basic Auth password", required=True)

args = parser.parse_args()
"""
***** END Arguments *****
"""

"""
***** Ping *****
"""
url = args.url
login = args.login
pwd = args.pwd

payload = "{ \"id\": 0, \"method\": \"getbalance\", \"params\": {} }"

headers = {
    'Content-Type': "application/json",
}

response = requests.request("POST", url, data=payload, headers=headers,
                            auth=HTTPBasicAuth(username=login, password=pwd))

assert_response_code_is_200(response)

content = response.content.decode('utf-8')
jsonBody = json.loads(content)

assert isinstance(jsonBody['result'], dict), "Result key in response body is not an object! Actual response is " + str(
    content)

assert 'confirmed' in jsonBody[
    'result'], "Result object should have `confirmed` key, but it doesn't!" + " Actual result is " + content

print("Ok...")
"""
***** END Ping *****
"""
