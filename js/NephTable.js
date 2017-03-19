/*
 * A repository class for all Nephilim RPG data
 */
var NephTable = function (rootDir) {
    this.rootDir = rootDir
    this.listing = ['magie', 'kabbale', 'alchimie']
    this.data = {}
    this.element = ['feu', 'air', 'eau', 'lune', 'terre']
    this.laboratoire = ['Métal', 'Vapeur', 'Liqueur', 'Poudre', 'Ambre']
    this.alliage = ['lionvert', 'hermes', 'esmeralda', 'atalante', 'rebis']
    this.sephirahOrder = {
        'Malkut': 10, 'Yesod': 9, 'Hod': 8, 'Netzah': 7, 'Tipheret': 6, 'Geburah': 5, 'Chesed': 4, 'Binah': 3, 'Chokmah': 2, 'Kether': 1
    }
    this.monde = ['Aresh', 'Meborack', 'Pachad', 'Sohar', 'Zakaï']
}

NephTable.prototype.getSubstanceForAlliage = function (k) {
    var idx = this.alliage.indexOf(k)

    return this.laboratoire[idx]
}

NephTable.prototype.getAlliageForSubstance = function (k) {
    var idx = this.laboratoire.indexOf(k)

    return this.alliage[idx]
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
    //console.log(grid)

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

// sorting
NephTable.prototype.sortInvoc = function (tab) {
    var self = this

    tab.sort(function (a, b) {
        var cmp = a.Monde.localeCompare(b.Monde)
        if (cmp != 0) {
            if (a.Monde === 'Tous') {
                return 1
            } else if (b.Monde === 'Tous') {
                return -1
            }

            return cmp
        } else {
            cmp = self.sephirahOrder[b.Sephirah] - self.sephirahOrder[a.Sephirah]
            if (cmp != 0) {
                return cmp
            } else {
                return a.Element.localeCompare(b.Element)
            }
        }
    })
}

NephTable.prototype.findSubstance = function (word, filter) {
    console.log(filter)
    var table = this.get('alchimie')
    var found = []
    var regex = new RegExp(word, 'i')

    for (var k in table) {
        var row = table[k]
        var niv = parseInt(row.Cercle.split(0, 1))
        var sub = row.Substance
        var ka = row.Element

        switch (niv) {
            case 1 :
                if (!filter.outil[sub])
                    continue
                break
            case 2:
                if (!filter.substance[sub][ka])
                    continue
                break
            case 3:
                if (!filter.substance[sub][ka]
                        || !filter.alliage[this.getAlliageForSubstance(sub)])
                    continue
        }

        if (regex.test(row['Sort']) || regex.test(row['Effet'])) {
            found.push(row)
        }

    }

    return found
}
