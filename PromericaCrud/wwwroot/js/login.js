
class Login {
    constructor() {
        this.initEvents();
    }


    initEvents() {
        const self = this;
        $('#formInicio').submit((e) => {
            e.preventDefault();
            self.inicioSesion();
        })
    }

    inicioSesion() {
        $.ajax({
            method: 'post',
            url: 'Home/InicioSesion',
            dataType: 'json',
            data: $('#formInicio').serialize()
        }).then(response => {
            console.log(response);
        })
    }
}
