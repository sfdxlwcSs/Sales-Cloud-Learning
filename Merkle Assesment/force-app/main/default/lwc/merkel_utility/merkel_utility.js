/**
 * @description       : 
 * @author            : Somnath Sharma
 * @group             : 
 * @last modified on  : 08-05-2023
 * @last modified by  : Somnath Sharma
**/
let UUIDGENERATE = () => {
    return randomAlphaNumeicCode() + uuidv4().substring(0, 12); //18digits max factored '-'[index] append when in loop
};

const isNotBlank = checkString => {
    return (checkString !== '' && checkString !== null && checkString !== undefined);
};
const isBlank = (checkString) => {
    return (checkString === '' || checkString === null || checkString === undefined);
};


const deepCopyFunction = (inObject) => {
    let outObject, value, key;

    if (typeof inObject !== "object" || inObject === null) {
        return inObject; // Return the value if inObject is not an object
    }

    // Create an array or object to hold the values
    outObject = Array.isArray(inObject) ? [] : {};

    for (key in inObject) {
        value = inObject[key];

        // Recursively (deep) copy for nested objects, including arrays
        outObject[key] = deepCopyFunction(value);
    }

    return outObject;
};
export {

    isNotBlank,
    UUIDGENERATE,
    deepCopyFunction,
    isBlank
};