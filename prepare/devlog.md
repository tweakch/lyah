# Prepare

We are going to work through [Learn you a Haskell for great good](http://learnyouahaskell.com/)

In order to do so we first need to setup the haskell platform on our machine

## Setup Haskell Platform on Windows

### 1 Configure Chocolatey

[Configure Chocolatey](https://chocolatey.org/install) on your machine

### 2 Clean cabal config

Clean the cabal configuration (if you are upgrading the old-style haskell platform installer)

```sh
cabal user-config init -f 
```
Then uninstall prior versions of the platform

### 3 At an elevated command promt, run:

```sh
cabal user-config init -f 
```

