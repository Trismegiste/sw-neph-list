<list-magie>
    <form class="pure-form pure-g">
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
                <td>{row['Le mage…']}</td>
                <td>{row['Chaîne']}</td>
            </tr>
        </tbody>
    </table>

    <script>
        this.listing = nephData.get('magie')
        this.found = []
        var self = this

        this.onSearch = function () {
            var regex = new RegExp(self.keyword.value, 'i')
            self.found = []
            for (var k in self.listing) {
                var row = self.listing[k]
                if (regex.test(row['Chaîne']) || regex.test(row["Effet (avec Relance)"])) {
                    row.pk = k
                    self.found.push(row)
                }
            }
        }

        this.onDetail = function (e) {
            riot.route('magie/' + e.item.row.pk)
        }
    </script>

</list-magie>