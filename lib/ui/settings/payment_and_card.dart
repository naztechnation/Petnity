import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';

import '../../res/app_strings.dart';
import '../widgets/back_button.dart';

class PaymentAndCard extends StatelessWidget {
  final TextEditingController number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightBackground,
      appBar: PreferredSize(
        preferredSize: screenSize(context) * .1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: AppColors.lightBackground,
            leading: backButton(context),
            title: Text(
              'Cards and Payment',
             style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: AppStrings.interSans
                        
                        ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:20.0),
                  child: Text('Payment systems', style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: AppStrings.interSans
                              
                              ),),
                ),
                            const SizedBox(height: 12,),
                _PaymentSystemTile(
                    title: 'Debit/ Credit Card',
                    route: Container(),
                    onpressed: () => Navigator.pushNamed(context, 'savedCards'),
                    icon: Icon(
                      Icons.payment,
                      color: Colors.black,
                    )),
                _PaymentSystemTile(
                    onpressed: () {},
                    title: 'Google Pay',
                    route: Container(),
                    icon: Icon(
                      Icons.payment,
                      color: Colors.black,
                    )),
                _PaymentSystemTile(
                    onpressed: () {},
                    title: 'Crypto Wallet',
                    route: Container(),
                    icon: Icon(
                      Icons.payment,
                      color: Colors.black,
                    )),
                _PaymentSystemTile(
                    onpressed: () {},
                    title: 'Apple Pay',
                    route: Container(),
                    icon: Icon(
                      Icons.payment,
                      color: Colors.black,
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20.0),
                  child: Text('Transactions',style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontFamily: AppStrings.interSans
                                
                                ),),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'transactions');
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: screenSize(context).height * .1,
                        width: screenSize(context).width * .9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$456',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Sandra Jessica',style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: AppStrings.interSans
                            
                            ),)
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Sent',
                                 style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                            fontFamily: AppStrings.interSans
                            
                            ),
                                ),
                                Text(
                                  'ID: 01123456788',
                                  style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: AppStrings.montserrat
                            
                            ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: 6,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _PaymentSystemTile({
    required String title,
    required Widget route,
    required Widget icon,
    required VoidCallback onpressed,
  }) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          
                          ),
        ),
        trailing: icon,
        onTap: onpressed,
      ),
    );
  }
}
