from curses.ascii import SP
from brownie import (
    Sprint69,
    Standard_Token,
    accounts,
    convert,
    network
)


def main():
    sprint = Sprint69.deploy(
        Standard_Token[-1].address,
        {"from": accounts[0]}
    )


if __name__ == "__main__":
    main()
