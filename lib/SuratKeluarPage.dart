import 'package:flutter/material.dart';
import 'package:simas/SuratKeluarModel.dart';
import 'database.dart';
class SuratKeluarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Surat Keluar'),
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
                    leading: Text(data.IdSuratKeluar),
                    title: Text(data.NomorUrut),
                    subtitle: Text(data.IsiRingkas),

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

Future<List<SuratKeluarModel>> getmySQLData() async {
  var db = Mysql();
  String sql = 'select * from surat_keluar;';
  final List<SuratKeluarModel> mylist = [];
  await db.getConnection().then((conn) async {
    await conn.query(sql).then((results) {
      for (var res in results) {
        final SuratKeluarModel myuser = SuratKeluarModel(
          IdSuratKeluar: res['IdSuratKeluar'].toString(),
          NomorUrut: res['NomorUrut'].toString(),
          NomorDanTanggal: res['NomorDanTanggal'].toString(),
          IsiRingkas: res['IsiRingkas'].toString(),
          HubNomorAgenda: res['HubNomorAgenda'].toString(),
          Keterangan: res['Keterangan'].toString(),

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