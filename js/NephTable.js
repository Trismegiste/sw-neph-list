/*
 * A repository class for all Nephilim RPG data
 */
var NephTable = function (rootDir) {
    this.rootDir = rootDir
    this.listing = ['magie', 'kabbale', 'alchimie']
    this.data = {}
    this.laboratoire = ['Métal', 'Liqueur', 'Vapeur', 'Poudre', 'Ambre']
    this.sephirahOrder = {
        'Malkut': 10, 'Yesod': 9, 'Hod': 8, 'Netzah': 7, 'Tipheret': 6, 'Geburah': 5, 'Chesed': 4, 'Binah': 3, 'Chokmah': 2, 'Kether': 1
    }
    this.monde = ['Aresh', 'Meborack', 'Pachad', 'Sohar', 'Zakaï']
}

NephTable.prototype.createPromise = function (filename) {
    var self = this

    return new Promise(function (fulfill, reject) {
        fetch(self.rootDir + filename + '.json').then(function (response) {
            return response.json()
        }).then(function (content) {
            fulfill([filename, content])
        })
    })
}

NephTable.prototype.load = function () {
    var self = this

    var loading = []
    for (var idx in this.listing) {
        loading.push(this.createPromise(this.listing[idx]))
    }

    return new Promise(function (fulfill, reject) {
        Promise.all(loading).then(function (loaded) {
            for (var k in loaded) {
                var result = loaded[k][1]
                var key = loaded[k][0]
                // indexing table
                for (var idx in result) {
                    result[idx].pk = idx
                }
                // store
                self.data[key] = result
            }
            fulfill()
        })
    })
}

NephTable.prototype.get = function (key) {
    if (!this.data.hasOwnProperty(key)) {
        throw new Error(key + ' not found')
    }
    return this.data[key]
}

NephTable.prototype.findInvoc = function (word, filter) {
    var table = this.get('kabbale')
    var found = []
    var grid = []

    // filtre sur le monde :
    if (filter !== undefined) {
        var minSph = 11;
        for (var idx in this.monde) {
            var val = this.monde[idx]
            if (filter[val] !== undefined) {
                grid[val] = filter[val]
            } else {
                grid[val] = 11
            }
            if (grid[val] < minSph) {
                minSph = grid[val]
            }
        }
        grid['Tous'] = minSph
    } else {
        for (var idx in this.monde) {
            grid[this.monde[idx]] = 1
        }
        grid['Tous'] = 1
    }
    console.log(grid)

    // filtre sur le mot :
    var regex = new RegExp(word, 'i')

    for (var idx in table) {
        var row = table[idx]
        if (this.sephirahOrder[row.Sephirah] >= grid[row.Monde]) {
            if (regex.test(row['Sort']) || regex.test(row['Effet'])) {
                found.push(row)
            }
        }
    }

    return found
}