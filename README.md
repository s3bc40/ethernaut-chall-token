# Ethernaut challenge Token

This repo has the exploration code to understand how to steal tokens.

It was an arthmetic issue -> overflow and underflow

The cod allows to get the contract address to steal the tokens. But to complete the challenge, it needs the `player` address to get the funds.

I used `foundry` with its commad line `cast` to send an encoded transaction to the level contract:

```sh
cast send 0xCONTRACT_ADDRESS $FUNCTION_ENCODED --rpc-url $SEPOLIA_URL --account MY_ENCRYPTED_ACCOUNT
```
