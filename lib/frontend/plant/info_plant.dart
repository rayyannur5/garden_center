import 'package:flutter/material.dart';
import 'package:garden_center/frontend/widgets/style.dart';

class InfoPlant extends StatelessWidget {
  final String title;
  final String desc;
  final String img;
  const InfoPlant({super.key, required this.title, required this.desc, required this.img});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 33),
          height: 50,
          child: Material(
            borderRadius: BorderRadius.circular(25),
            elevation: 10,
            color: Colors.green,
            child: InkWell(
              onTap: null,
              child: Center(
                child: Text(
                  "Tanam",
                  style: TextStyle(fontFamily: "Poppins", color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              collapsedHeight: 120,
              pinned: true,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    height: 40,
                    width: 40,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.navigate_before,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Material(
                      shape: CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: InkWell(
                          child: Image.asset("assets/icon/discord 1.png"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: title,
                  child: Image.network(
                    img,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(33, 10, 0, 10),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                  ),
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(33, 0, 33, 0),
                child: Text(
                  desc,
                  style: TextStyle(fontFamily: "Poppins"),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(33, 10, 33, 0),
                child: Text(
                  "Jagung (Zea mays ssp. mays) adalah salah satu tanaman pangan penghasil karbohidrat yang terpenting di dunia, selain gandum dan padi. Bagi penduduk Amerika Tengah dan Selatan, bulir jagung adalah pangan pokok, sebagaimana bagi sebagian penduduk Afrika dan beberapa daerah di Indonesia. Pada masa kini, jagung juga sudah menjadi komponen penting pakan ternak. Penggunaan lainnya adalah sebagai sumber minyak pangan dan bahan dasar tepung maizena. Berbagai produk turunan hasil jagung menjadi bahan baku berbagai produk industri farmasi, kosmetika, dan kimia.",
                  textAlign: TextAlign.justify,
                  style: AppStyle.paragraph,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(33, 10, 33, 0),
                child: Text(
                  "Tips & Tricks",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(33, 10, 33, 0),
                child: Text(
                  "1. Pilih Bibit Jagung yang Bagus\nCara menanam jagung yang terpenting adalah memilih bibitnya. Sebaiknya Moms memilih bibit jagung kualitas unggul atau merk terkenal jika Moms membelinya di kios pertanian.\n\n" +
                      "2. Siapkan Tanah untuk Media Tanam\nUntuk menanam jagung dibutuhkan tanah yang gembur. Namun, pertama-tama, tanah harus bersih dari sisa tanaman lama atau rumput-rumputan.\n\n" +
                      "3. Menanam Bibit Jagung\nTaburkan benih jagung sedalam 3 hingga 5 cm, setiap lubang bisa dimasukan 2-3 biji jagung. Apabila jenis jagung besar ditanam dan tidak diselingi dengan tanaman lain, maka jarak yang baik yaitu antara 90 x 60 cm.\n\n" +
                      "4. Waktu Penyiraman\nSirami jagung dua hingga tiga kali seminggu, atau ketika 3 cm bagian atas tanah mulai mengering. Berikan jagung dengan air sampai membasahi sekitar 5 cm permukaan tanahnya setiap minggu.\n\n\n\n",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontFamily: "Poppins"),
                ),
              ),
            ),
          ],
        ));
  }
}
