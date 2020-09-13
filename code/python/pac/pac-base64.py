import base64

if __name__ == '__main__':
    with open(r"./gfwlist.txt", "rb") as gfwlist:
        b_wlist = base64.b64decode(gfwlist.read())
        wlist_text =  b_wlist.decode('utf-8')
        print(wlist_text)
        gfwlist.close()
        with open(r"./fwlist.md", "w") as fwlist:
            fwlist.write(wlist_text)
            fwlist.close()