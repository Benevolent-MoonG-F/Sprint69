from brownie import (
    network,
    accounts,
    config,
    Standard_token,
    convert
)


def main():
    token = Standard_token.deploy(
        convert.to_uint("2000000 ether"),
        "Test Token",
        18,
        "TTKN",
        {"from": accounts[0]}
    )


if __name__ == "__main__":
    main()
