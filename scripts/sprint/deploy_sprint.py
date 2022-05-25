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
    token = Standard_Token.deploy(
        convert.to_uint("2000000 ether"),
        "Sprint Test Token",
        18,
        "STT",
        {"from": account}
    )
    api = SprintApi.deploy(
        convert.to_address("0xa36085F69e2889c224210F603D836748e7dC0088"),
        convert.to_address("0x74EcC8Bdeb76F2C6760eD2dc8A46ca5e581fA656"),
        "53f9755920cd451a8fe46f5087468395",
        {"from": account}
    )
    sprint = Sprint69.deploy(
        Standard_Token[-1].address,
        api.address,
        {"from": accounts[0]}
    )


if __name__ == "__main__":
    main()
