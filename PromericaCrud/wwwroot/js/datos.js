class Datos {
    constructor() {
        this.initEvents();
    }


    initEvents() {
        const self = this;
        console.log('a')
        $('#formCreate').submit((e) => {
            e.preventDefault();
            self.create();
        })

        $('#formUpdate').submit((e) => {
            e.preventDefault();
            self.edit();
        })

        $('#formDelete').submit((e) => {
            e.preventDefault();
            self.delete();
        })

        $('#formSelect').submit((e) => {
            e.preventDefault();
            self.select();
        })
    }

    create() {
        $.ajax({
            method: 'post',
            url: 'Datos/Create',
            dataType: 'json',
            data: $('#formCreate').serialize()
        }).then(response => {
            $('#crearFila').text('FILAS AFECTADOS=' + response)
        }).catch(() => {
            $('#updateFila').text('NO SE PUEDO REALIZAR LA OPERACION')
        })
    }

    edit() {
        $.ajax({
            method: 'post',
            url: 'Datos/Update',
            dataType: 'json',
            data: $('#formUpdate').serialize()
        }).then(response => {
            $('#updateFila').text('FILAS AFECTADOS=' + response)
            
        }).catch(() => {
            $('#updateFila').text('NO SE PUEDO REALIZAR LA OPERACION')
        })
    }

    delete() {
        $.ajax({
            method: 'post',
            url: 'Datos/Delete',
            dataType: 'json',
            data: $('#formDelete').serialize()
        }).then(response => {
            $('#DeleteFila').text('FILAS AFECTADOS =' + response)
            
        }).catch(() => {
            $('#updateFila').text('NO SE PUEDO REALIZAR LA OPERACION')
        })
    }

    select() {
        $.ajax({
            method: 'get',
            url: 'Datos/Get',
            dataType: 'json',
            data: $('#formSelect').serialize()
        }).then(response => {
            $('#selectFila').text('FILAS AFECTADOS=' + response)
            
        }).catch(() => {
            $('#updateFila').text('NO SE PUEDO REALIZAR LA OPERACION')
        })
    }
}