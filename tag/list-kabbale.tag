<list-kabbale>
    <form class="pure-form pure-g form-label-aligned" onchange="{
                onSearch
            }">
        <virtual each="{titre, idx in monde}">
            <div class="pure-u-1-4">
                <label>{titre}</label>
            </div>
            <div class="pure-u-1-4">
                <select class="pure-input-1" value="{ config[idx] }" name="filter">
                    <option value="0"></option>
                    <option each="{key, val in sephirahOrder}" value="{val}">{key}</option>
                </select>
            </div>
        </virtual>
        <div class="pure-u-1">
            <input type="text" name="keyword" class="pure-input-1" onkeyup="{
                        onSearch
                    }"/>
        </div>
    </form>

    <table class="pure-table pure-table-striped">
        <tbody>
            <tr each="{row, idx in found}" onclick="{
                        parent.onDetail
                    }">
                <td><img src="./img/elem/{row.Element.toLowerCase()}.svg"/></td>
                <td>{row.Sort}</td>
            </tr>
        </tbody>
    </table>

    <script>
        this.kabbaleList = nephData.get('kabbale')
        this.found = []
        this.sephirahOrder = nephData.sephirahOrder
        this.monde = nephData.monde
        var self = this
        // client config
        this.config = myConfig.read('kabbale-config', [])

        this.onSearch = function () {
            var mondeFilter = {}
            for (var idx in self.filter) {
                var sel = self.filter[idx]
                self.config[idx] = sel.value
                if (sel.value > 0) {
                    mondeFilter[self.monde[idx]] = sel.value
                }
            }
            myConfig.write('kabbale-config', self.config)

            var regex = new RegExp(self.keyword.value, 'i')
            self.found = []
            for (var k in self.kabbaleList) {
                var row = self.kabbaleList[k]
                if (regex.test(row['Sort']) || regex.test(row['Effet'])) {
                    if (row.Monde === 'Tous') {
                        for (var i in mondeFilter) {
                            if (self.sephirahOrder[row.Sephirah] >= mondeFilter[i]) {
                                row.pk = k
                                self.found.push(row)
                                break;
                            }
                        }
                    } else if ((mondeFilter[row.Monde] !== undefined)
                            && (self.sephirahOrder[row.Sephirah] >= mondeFilter[row.Monde])) {
                        row.pk = k
                        self.found.push(row)
                    }
                }
            }

            // sorting
            self.found.sort(function (a, b) {
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

        this.onDetail = function (e) {
            riot.route('kabbale/' + e.item.row.pk)
        }
    </script>
</list-kabbale>