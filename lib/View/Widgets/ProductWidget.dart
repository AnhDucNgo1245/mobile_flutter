import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm
            Expanded(
              flex: 3,
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.bottomRight,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/Minions_poster.jpg",
                          width: double.infinity,
                          height: 500,
                        ),
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {},
                        label: Text("Add to Cart"),
                        icon: Icon(Icons.shopping_cart),
                      ),
                    ],
                  ),
                ),
              ),

              // Tên sản phẩm + giá + rating
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "Product Name: Skibidi Toilet",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Price: 300\$",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.star, color: Colors.red),
                        SizedBox(width: 4),
                        Text(
                          "6.7",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Mô tả sản
              const Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: SingleChildScrollView(
                    child: Text(
                      '"Brainrot" (tạm dịch: thối não) là thuật ngữ mạng xã hội mô tả tình trạng sa sút nhận thức do tiêu thụ quá mức các nội dung trực tuyến vô nghĩa, lặp đi lặp lại. Hiện nay, "Brainrot" còn là một vũ trụ meme tạo bởi AI, thu hút giới trẻ nhờ hình ảnh siêu thực và âm thanh gây nghiện.',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
    }
  }
