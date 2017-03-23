<list-magie>
    <form class="pure-form pure-g" onsubmit="{
                noSubmit
            }">
        <div class="pure-u-1">
            <input type="text" placeholder="Texte à chercher" name="keyword" class="pure-input-1" onkeyup="{
                        onSearch
                    }"/>
        </div>
    </form>

    <table class="pure-table pure-table-striped listing">
        <tbody>
            <tr each="{row, idx in found}" onclick="{
                        parent.onDetail
                    }">
                <td><i class="icon-{row['Élément'].toLowerCase()}"></i></td>
                <td>{row['verbe']}</td>
                <td><div each="{variant in row['Chaîne'].split('\n')}">{variant}</div></td>
                <td class="xl-visible">{row.Cible}</td>
                <td class="xl-visible">{row["effet"]}</td>
            </tr>
        </tbody>
    </table>

    <script>
        this.listing = nephData.get('magie')
        this.found = []
        var self = this

        this.noSubmit = function () {
            // to make the virtual keyboard disappeard on mobile
            self.keyword.blur()
        }

        this.onSearch = function () {
            var regex = new RegExp(self.keyword.value.trim(), 'i')
            self.found = []
            for (var k in self.listing) {
                var row = self.listing[k]
                if (regex.test(row['Chaîne']) || regex.test(row["effet"])) {
                    self.found.push(row)
                }
            }

            self.found.sort(function (a, b) {
                var cmp = a.Cercle - b.Cercle
                if (cmp === 0) {
                    cmp = a['Élément'].localeCompare(b['Élément'])
                }

                return cmp
            })
        }

        this.onDetail = function (e) {
            riot.route('magie/' + e.item.row.pk)
        }
    </script>

</list-magie>