import json

print("loading function")

def lambda_handler(event, context):
    print("-----from handler-----")
    print("value1 : " + event["k1"])
    return event["k1"]

if __name__ == '__main__':
    print ("yes")
    e = {
        "k1": "v1",
        "k2": "v2",
        "k2": "v3"
    }
    lambda_handler(e,1)