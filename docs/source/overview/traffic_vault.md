Traffic Vault
=============

Traffic Vault is a keystore used for storing the following types of
information:

-   

    SSL Certificates

    :   -   Private Key
        -   CRT
        -   CSR

-   

    DNSSEC Keys

    :   -   

            Key Signing Key

            :   -   private key
                -   public key

        -   

            Zone Signing Key

            :   -   private key
                -   public key

-   URL Signing Keys

As the name suggests, Traffic Vault is meant to be a "vault" of private
keys that only certain users are allowed to access. In order to create,
add, and retrieve keys a user must have admin privileges. Keys can be
created via the Traffic Ops UI, but they can only be retrieved via the
Traffic Ops API. The keystore used by Traffic Vault is
[Riak](http://basho.com/riak/). Traffic ops accesses Riak via https on
port 8088. Traffic ops uses Riak's rest API with username/password
authentication. Information on the API can be found
[here](http://docs.basho.com/riak/latest/dev/references/http/).
