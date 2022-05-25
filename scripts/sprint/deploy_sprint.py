from curses.ascii import SP
from brownie import (
    Sprint69,
    Standard_Token,
    SprintApi,
    accounts,
    convert,
    network,
    config
)
from scripts.helpful_scripts import get_account

account = get_account()


def main():
    # token = Standard_Token.deploy(
    #    convert.to_uint("2000000 ether"),
    #    "Sprint Test Token",
    #    18,
    #    "STT",
    #    {"from": account}
    # )
    # api = SprintApi.deploy(
    #    convert.to_address("0xa36085F69e2889c224210F603D836748e7dC0088"),
    #    convert.to_address("0x74EcC8Bdeb76F2C6760eD2dc8A46ca5e581fA656"),
    #    "53f9755920cd451a8fe46f5087468395",
    #    {"from": account}
    # )
    # data = [
    #    (53283230290, "USDC", 1, "urlUSDC",
    #     "https://min-api.cryptocompare.com/data/price?fsym=USDC&tsyms=USD"),
    #    (163276975, "BNB", 2, "urlBNB",
    #     "https://min-api.cryptocompare.com/data/price?fsym=BNB&tsyms=USD"),
    #    (48343101197, "XRP", 3, "urlXRP",
    #     "https://min-api.cryptocompare.com/data/price?fsym=XRP&tsyms=USD"),
    #    (339268332, "SOL", 4, "urlSOL",
    #     "https://min-api.cryptocompare.com/data/price?fsym=SOL&tsyms=USD"),
    #    (33820262544, "ADA", 5, "urlADA",
    #     "https://min-api.cryptocompare.com/data/price?fsym=ADA&tsyms=USD"),
    #    (270791556, "AVAX", 6, "urlAVAX",
    #     "https://min-api.cryptocompare.com/data/price?fsym=AVAX&tsyms=USD"),
    #    (132670764300, "DODGE", 7, "urlDODGE",
    #     "https://min-api.cryptocompare.com/data/price?fsym=DODGE&tsyms=USD"),
    #    (987579315, "DOT", 8, "urlDOT",
    #     "https://min-api.cryptocompare.com/data/price?fsym=DOT&tsyms=USD")
    # ]
    #i = 0
    # while i <= 7:
    #    feed = data[i]
    #    api.addAssetUrl(
    #        feed[0],
    #        feed[1],
    #        feed[2],
    #        feed[3],
    #        feed[4],
    #        {"from": account}
    #    )
    #    i = +1

    sprint = Sprint69.deploy(
        Standard_Token[-1].address,
        SprintApi[-1].address,
        {"from": account}
    )


if __name__ == "__main__":
    main()
