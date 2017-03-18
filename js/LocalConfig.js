/*
 * Config in localStorage
 */

LocalConfig = function () {

}

LocalConfig.prototype.read = function (key, defaultVal) {
    var val = localStorage.getItem(key);
    if (null === val) {
        val = defaultVal
    } else {
        val = JSON.parse(val)
    }

    return val
}

LocalConfig.prototype.write = function (key, obj) {
    localStorage.setItem(key, JSON.stringify(obj))
}
