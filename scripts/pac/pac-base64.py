import base64

if __name__ == '__main__':
    with open(r"./gfwlist.txt", "rb") as gfwlist:
        gfwlist_text = base64.b64decode(gfwlist.read())
        print(gfwlist_text)
        gfwlist.close()