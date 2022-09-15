import 'package:flutter/material.dart';
import 'package:simas/database/Database.dart';
import 'package:simas/model/UserModel.dart';
import 'package:simas/model/SuratMasukModel.dart';
class DashboardPage extends StatelessWidget {
  const DashboardPage();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: [

                  Tab(
                    text: 'Dashboard',
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SuratMasuk(),
          ],
        ),
      ),
    );
  }
}


class SuratMasuk extends StatefulWidget {
  @override
  _IncomingPageState createState() => _IncomingPageState();
}

class _IncomingPageState extends State<SuratMasuk>
    with AutomaticKeepAliveClientMixin<SuratMasuk> {
  int count = 10;

  void clear() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


      //fitur digunakan untuk refresh tarik kebawah
      body: RefreshIndicator(
        onRefresh: () =>
            getmySQLDataMasuk(),
        color: Colors.red,
        child: Container(
          margin: EdgeInsets.all(10),
          //ketika page ini di akses maka meminta data ke api
          child: FutureBuilder(
            future: getmySQLDataMasuk(),
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
                      onPressed: getmySQLDataMasuk,
                      child: const Icon(Icons.edit),
                    ),
                    leading: Text(data.IdSuratMasuk),
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

  @override
  bool get wantKeepAlive => true;
}


Future<List<SuratMasukModel>> getmySQLDataMasuk() async {
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
