<list-alchimie>
    <form class="pure-form" onChange="{
                onSearch
            }">
        <section class="laboratory">
            <div class="pure-g">
                <div class="pure-u-1-5" each="{ substanc, idx in laboratoire }">
                    <i class="icon-{substanc.toLowerCase()} {disabled: true}"></i><!-- checked="{ config[idx] }" -->
                </div>
            </div>
            <div class="pure-g " each="{ elem, row in element }">
                <div class="pure-u-1-5" each="{ substanc, col in laboratoire }">
                    <i class="icon-{elem} {disabled: true}"></i>
                </div>
            </div>
            <div class="pure-g">
                <div class="pure-u-1-5" each="{ title in nephData.alliage }">
                    <i class="icon-{title} {disabled: true}"></i>
                </div>
            </div>
        </section>
        <div class="pure-g">
            <div class="pure-u-1">
                <input type="text" name="keyword" class="pure-input-1" onkeyup="{
                            onSearch
                        }"/>
            </div>
        </div>
    </form>

    <table class="pure-table pure-table-striped">
        <tbody>
            <tr each="{row, idx in found}" onclick="{
                        parent.onDetail
                    }">
                <td><i class="icon-{row.Element.toLowerCase()}"></i></td>
                <td>{row.Sort}</td>
            </tr>
        </tbody>
    </table>

    <script>
        this.listing = nephData.get('alchimie')
        this.laboratoire = nephData.laboratoire
        this.found = []
        this.element = nephData.element
        var self = this
        // client config
        if (null === localStorage.getItem('alchimie-config')) {
            localStorage.setItem('alchimie-config', '[]')
        }
        this.config = JSON.parse(localStorage.getItem('alchimie-config'))


        this.onSearch = function () {
            var substance = []
            for (var idx in self.laboChoice) {
                var sel = self.laboChoice[idx]
                self.config[idx] = sel.checked
                if (sel.checked) {
                    substance.push(self.laboratoire[idx])
                }
            }
            localStorage.setItem('alchimie-config', JSON.stringify(self.config))

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

        this.onDetail = function (e) {
            riot.route('alchimie/' + e.item.row.pk)
        }
    </script>
</list-alchimie>