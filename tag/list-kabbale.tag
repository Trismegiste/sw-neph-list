<list-kabbale>
    <form class="pure-form pure-g form-label-aligned" onchange="{
                onSearch
            }">
        <div class="pure-u-1">
            <input type="text" name="keyword" class="pure-input-1" onkeyup="{
                        onSearch
                    }"/>
        </div>
        <virtual each="{titre, idx in monde}">
            <div class="pure-u-1-4">
                <label>{titre}</label>
            </div>
            <div class="pure-u-1-4">
                <select class="pure-input-1" value="{ config[idx] }" name="filter">
                    <option>--pas--</option>
                    <option each="{key, val in sephirahOrder}" value="{val}">{key}</option>
                </select>
            </div>
        </virtual>
    </form>

    <table class="pure-table pure-table-striped">
        <tbody>
            <tr each="{row, idx in found}" onclick="{
                        parent.onDetail
                    }">
                <td>{row.Monde}</td>
                <td>{row.Sephirah}</td>
                <td>{row.Element}</td>
                <td>{row.Sort}</td>
            </tr>
        </tbody>
    </table>

    <script>
        this.kabbaleList = nephData.get('kabbale')
        this.found = []
        this.sephirahOrder = {
            'Malkut': 10, 'Yesod': 9, 'Hod': 8, 'Netzah': 7, 'Tipheret': 6, 'Geburah': 5, 'Chesed': 4, 'Binah': 3, 'Chokmah': 2, 'Kether': 1
        }
        this.monde = ['Aresh', 'Meborack', 'Pachad', 'Sohar', 'Zakaï'] // ne pas oublier 'Tous' !
        this.config = [7]
        var self = this

        onSearch() {
            var mondeFilter = {}
            for (var idx in self.filter) {
                var sel = self.filter[idx]
                if (sel.value > 0) {
                    mondeFilter[self.monde[idx]] = sel.value
                }
            }
            //console.log(mondeFilter)

            var regex = new RegExp(self.keyword.value, 'i')
            self.found = []
            for (var k in self.kabbaleList) {
                var row = self.kabbaleList[k]
                if ((mondeFilter[row.Monde] !== undefined)
                        && (self.sephirahOrder[row.Sephirah] >= mondeFilter[row.Monde])) {
                    if (regex.test(row['Sort'])) {
                        row.pk = k
                        self.found.push(row)
                    }
                }
            }

            // sorting
            self.found.sort(function (a, b) {
                var cmp = a.Monde.localeCompare(b.Monde)
                if (cmp != 0) {
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

        onDetail(e) {
            riot.route('kabbale/' + e.item.row.pk)
        }
    </script>
</list-kabbale>