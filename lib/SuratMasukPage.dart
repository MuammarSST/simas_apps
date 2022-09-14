import 'package:flutter/material.dart';
import 'package:simas/SuratMasukModel.dart';
import 'database.dart';
class SuratMasukPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Surat Masuk'),
      ),

      //fitur digunakan untuk refresh tarik kebawah
      body: RefreshIndicator(
        onRefresh: () =>
        getmySQLData(),
        color: Colors.red,
        child: Container(
          margin: EdgeInsets.all(10),
          //ketika page ini di akses maka meminta data ke api
          child: FutureBuilder(
            future: getmySQLData(),
            builder: (context, snapshot) {
              //jika proses request masih berlangsung

              if (snapshot.connectionState == ConnectionState.waiting) {
                //maka kita tampilkan indikator loading
                return Center(
                  child: CircularProgressIndicator(),
                );
              }


                  return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                  final data = snapshot.data![index];
                  return ListTile(
                  trailing: TextButton(
                  onPressed: getmySQLData,
                  child: const Icon(Icons.edit),
                  ),
                  leading: Text(data.IdSuratMasuk),
                  title: Text(data.NomorUrut),
                  subtitle: Text(data.Pengirim),

                );

                },
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<List<SuratMasukModel>> getmySQLData() async {
  var db = Mysql();
  String sql = 'select * from surat_masuk;';
  final List<SuratMasukModel> mylist = [];
  await db.getConnection().then((conn) async {
    await conn.query(sql).then((results) {
      for (var res in results) {
        final SuratMasukModel myuser = SuratMasukModel(
            IdSuratMasuk: res['IdSuratMasuk'].toString(),
            NomorUrut: res['NomorUrut'].toString(),
            Pengirim: res['Pengirim'].toString(),
            NomorDanTanggal: res['NomorDanTanggal'].toString(),
            IsiRingkas: res['IsiRingkas'].toString(),
            HubNomorAgenda: res['HubNomorAgenda'].toString(),
            Keterangan: res['Keterangan'].toString(),
            Disposisi: res['Disposisi'].toString(),

        );
        mylist.add(myuser);

      }

    }).onError((error, stackTrace) {
      print(error);
      return null;

    });
    conn.close();
  });
  return mylist;
}