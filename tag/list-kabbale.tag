<list-kabbale>
    <form class="pure-form pure-g form-label-aligned" onchange="{
                onSearch
            }">
        <virtual each="{titre in monde}">
            <div class="pure-u-1-4">
                <label>{titre}</label>
            </div>
            <div class="pure-u-1-4">
                <select class="pure-input-1" value="{ config[titre] }" name="filter" onchange="{
                            parent.onChangeConfig
                        }">
                    <option value="11"></option>
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
        this.config = myConfig.read('kabbale-config', {})

        this.onChangeConfig = function (event) {
            var mondeSelect = event.item
            self.config[mondeSelect.titre] = parseInt(event.target.value)
            myConfig.write('kabbale-config', self.config)
        }

        this.onSearch = function () {
            self.found = nephData.findInvoc(self.keyword.value, self.config)

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