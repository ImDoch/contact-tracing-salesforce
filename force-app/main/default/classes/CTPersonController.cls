public with sharing class CTPersonController {
    public static String getToken(String mobileNumber) {
        Blob value = Blob.valueOf(mobileNumber);
        Blob hash = Crypto.generateDigest('MD5', value);
        return EncodingUtil.base64Encode(hash);
    }
}