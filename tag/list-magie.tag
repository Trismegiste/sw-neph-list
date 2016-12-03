<list-magie>
    <form class="pure-form pure-g">
        <div class="pure-u-1">
            <input type="text" name="keyword" class="pure-input-1" onkeyup="{
                        onSearch
                    }"/>
        </div>
    </form>

    <table class="pure-table pure-table-striped">
        <tbody>
            <tr each="{row, idx in found}" onclick="{parent.onDetail}">
                <td>{row['Chaîne']}</td>
                <td>{row['Élément']}</td>
            </tr>
        </tbody>
    </table>

    <script>
        this.listing = nephData.get('magie')
        this.found = []
        var self = this

        onSearch() {
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

        onDetail(e) {
            riot.route('magie/' + e.item.row.pk)
        }
    </script>

</list-magie>