<list-kabbale>

    <form class="pure-form">
        <input type="text" name="keyword" onkeyup="{
                    onSearch
                }"/>
    </form>

    <table class="pure-table">
        <tbody>
            <tr each="{row in found}">
                <td>{row.Sort}</td>
                <td>{row.Monde}</td>
            </tr>
        </tbody>
    </table>

    <script>
        this.kabbaleList = nephData.get('kabbale')
        this.found = []
        var self = this

        onSearch() {
            var regex = new RegExp(self.keyword.value, 'i')
            self.found = []
            for (var k in self.kabbaleList) {
                var row = self.kabbaleList[k]
                if (regex.test(row['Sort'])) {
                    self.found.push(row)
                }
            }
        }
    </script>
</list-kabbale>