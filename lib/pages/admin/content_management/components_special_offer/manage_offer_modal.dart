import 'package:flutter/material.dart';
import 'package:tim_app/backend/firebase/firebaseService.dart';
import 'package:tim_app/pages/admin/manage_business/components_view_business/tabbar_business_reviews.dart';
import 'package:tim_app/widgets/blurContainer.dart';
import 'package:tim_app/widgets/dialogs/success_dialog.dart';

class ManageOfferModal extends StatefulWidget {
  final Map<String, dynamic> item;
  const ManageOfferModal({super.key, required this.item});

  @override
  State<ManageOfferModal> createState() => _ManageOfferModalState();
}

class _ManageOfferModalState extends State<ManageOfferModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: BlurExpanded(
        width: MediaQuery.of(context).size.width * 0.50,
        childColumn: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                            width: 1.0,
                          ),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: Image.network(widget.item['imageURL'] ??
                                    'assets/images/empty-placeholder.png')
                                .image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.item['businessName'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.item['title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              widget.item['offerCode'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              widget.item['createAt'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.item['description'],
                              overflow: TextOverflow.visible,
                              softWrap: true,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        widget.item['status'] == 'Pending'
            ? ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Updating Data',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      );
                    },
                  );

                  debugPrint(widget.item['docID']);

                  await updateBusinessContent(
                          widget.item['docID'], 'special_offers', 'Declined')
                      .then((value) {
                    if (value == 'success') {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const SuccessDialog(
                            title: 'You updated the content',
                          );
                        },
                      );
                    } else {
                      // Non success action
                      debugPrint('Di pa okay');
                    }
                  });
                },
                child: const Text('Decline'),
              )
            : Text(''),
        widget.item['status'] == 'Pending'
            ? ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Updating Data',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      );
                    },
                  );

                  debugPrint(widget.item['docID']);

                  await updateBusinessContent(
                          widget.item['docID'], 'special_offers', 'Approved')
                      .then((value) {
                    if (value == 'success') {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const SuccessDialog(
                            title: 'You updated the content',
                          );
                        },
                      );
                    } else {
                      // Non success action
                      debugPrint('Di pa okay');
                    }
                  });
                },
                child: const Text('Approve Offer'),
              )
            : Text('')
      ],
    );
  }
}
