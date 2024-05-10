package de.hft_stuttgart.it_security_2;

import java.math.BigInteger;

public class DiffieHellmann {

    public static void main(String[] args) {
        BigInteger prime = new BigInteger("21");
        BigInteger base = new BigInteger("16");
        BigInteger secretA = new BigInteger("145");
        BigInteger secretB = new BigInteger("389");

        BigInteger publicA = base.modPow(secretA, prime);
        BigInteger publicB = base.modPow(secretB, prime);

        BigInteger sharedSecretA = publicB.modPow(secretA, prime);
        BigInteger sharedSecretB = publicA.modPow(secretB, prime);

        System.out.println("Public Key A: " + publicA);
        System.out.println("Public Key B: " + publicB);
        System.out.println("Shared Secret: " + sharedSecretA);
        System.out.println("Shared Secret the same? " + sharedSecretB.equals(sharedSecretA));
    }
}
