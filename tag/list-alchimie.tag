<list-alchimie>
    <form class="pure-form pure-g" onChange="{
                onSearch
            }">
        <div class="pure-u-1-5" each="{ substanc in laboratoire }">
            <label><img src="./img/outil/{substanc.toLowerCase()}.svg"/><input type="checkbox" name="laboChoice"/></label>
        </div>
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
        this.listing = nephData.get('alchimie')
        this.laboratoire = ['Métal', 'Liqueur', 'Vapeur', 'Poudre', 'Ambre']
        this.found = []
        var self = this

        onSearch() {
            var substance = []
            for (var idx in self.laboChoice) {
                var sel = self.laboChoice[idx]
                if (sel.checked) {
                    substance.push(self.laboratoire[idx])
                }
            }
            //console.log(substance)

            var regex = new RegExp(self.keyword.value, 'i')
            self.found = []
            for (var k in self.listing) {
                var row = self.listing[k]
                if (regex.test(row['Sort']) || regex.test(row['Effet'])) {
                    if (-1 !== substance.indexOf(row.Substance)) {
                        row.pk = k
                        self.found.push(row)
                    }
                }
            }
        }

        onDetail(e) {
            riot.route('alchimie/' + e.item.row.pk)
        }
    </script>
</list-alchimie>