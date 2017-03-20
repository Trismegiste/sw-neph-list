<list-kabbale>
    <form class="pure-form form-label-aligned" onsubmit="return false">
        <div class="pure-g">
            <div class="pure-u-xl-1-12"></div>
            <virtual each="{titre in monde}">
                <div class="pure-u-1-4 pure-u-xl-1-12">
                    <label>{titre}</label>
                </div>
                <div class="pure-u-1-4 pure-u-xl-1-12">
                    <select class="pure-input-1" value="{ config[titre] }" name="filter" onchange="{
                                parent.onChangeConfig
                            }">
                        <option value="11"></option>
                        <option each="{key, val in sephirahOrder}" value="{val}">{key}</option>
                    </select>
                </div>
            </virtual>
        </div>
        <div class="pure-g">
            <div class="pure-u-xl-1-12"></div>
            <div class="pure-u-1">
                <input type="text" name="keyword" class="pure-input-1" onkeyup="{
                            onSearch
                        }"/>
            </div>
        </div>
    </form>

    <table class="pure-table pure-table-striped listing">
        <tbody>
            <tr each="{row, idx in found}" onclick="{
                        parent.onDetail
                    }">
                <td class="xl-visible"><i class="icon-mdk-{row.Monde.toLowerCase()}"></i></td>
                <td class="xl-visible">{row.Sephirah}</td>
                <td><i class="icon-{row.Element.toLowerCase()}"></i></td>
                <td>{row.Sort}</td>
                <td class="xl-visible">{row.Effet}</td>
                <td class="xl-visible">{row['Portée']}</td>
                <td class="xl-visible">{row['Durée']}</td>
            </tr>
        </tbody>
    </table>

    <script>
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
            self.trigger('search')
        }

        this.on('search', function () {
            self.found = nephData.findInvoc(self.keyword.value, self.config)
            nephData.sortInvoc(self.found)
        })

        this.onSearch = function () {
            self.trigger('search')
        }

        this.onDetail = function (e) {
            riot.route('kabbale/' + e.item.row.pk)
        }
    </script>
</list-kabbale>