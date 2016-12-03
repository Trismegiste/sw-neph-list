<list-kabbale>

    <form class="pure-form pure-g">
        <div class="pure-u-1">
            <input type="text" name="keyword" class="pure-input-1" onkeyup="{
                        onSearch
                    }"/>
        </div>
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