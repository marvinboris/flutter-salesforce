import 'package:flutter/material.dart';

import '../models/product.dart';

import '../scoped_models/main.dart';

import '../widgets/ui_elements/blocks/invoice.dart';
import '../widgets/ui_elements/form/search.dart';
import '../widgets/ui_elements/navigation/bottom_navigation_bar.dart';
import '../widgets/ui_elements/navigation/header.dart';
import '../widgets/ui_elements/navigation/section_title.dart';

class ManageInvoicePage extends StatefulWidget {
  final MainModel model;

  const ManageInvoicePage(this.model, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ManageInvoicePageState();
  }
}

class _ManageInvoicePageState extends State<ManageInvoicePage> {
  final Map<String, dynamic> _formData = {
    'client': '',
    'product': '',
  };

  @override
  initState() {
    final clients = widget.model.allClients;
    final products = widget.model.allProducts;

    _formData['client'] = clients.isNotEmpty ? clients[0].name : '';
    _formData['product'] = products.isNotEmpty ? products[0].title : '';
    super.initState();
  }

  Widget _buildSelectField(
    BuildContext context,
    List<String> list,
    String value,
    void Function(String?)? onChanged,
  ) =>
      DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          value: value,
          onChanged: onChanged,
          items: list
              .map(
                (value) => DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontFamily: 'Euclid Circular A',
                      fontSize: 14,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );

  Widget _buildSearchField(
    BuildContext context,
    Widget child,
  ) =>
      Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300),
          color: Theme.of(context).primaryColor.withOpacity(.1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 19, right: 16),
              child: Icon(
                Icons.search_outlined,
                color: Theme.of(context).primaryColor.withOpacity(.5),
              ),
            ),
            Expanded(
              child: child,
            ),
            const SizedBox(width: 11),
          ],
        ),
      );

  Widget _buildClientSearchField(
    BuildContext context,
  ) =>
      _buildSearchField(
        context,
        _buildSelectField(
          context,
          widget.model.allClients.map((c) => c.name).toList(),
          _formData['client'],
          (String? value) => setState(() {
            _formData['client'] = value;
          }),
        ),
      );

  Widget _buildProductSearchField(BuildContext context) => _buildSearchField(
        context,
        Stack(
          children: [
            _buildSelectField(
              context,
              widget.model.allProducts.map((p) => p.title).toList(),
              _formData['product'],
              (String? value) => setState(() {
                _formData['product'] = value;
              }),
            ),
            Positioned(
              top: 5,
              right: 0,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  backgroundColor: Theme.of(context).primaryColor,
                  fixedSize: const Size(89, 40),
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    fontFamily: 'Euclid Circular A',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildButton(
    BuildContext context,
    IconData icon,
    void Function()? onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(24, 24),
        shape: const CircleBorder(),
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).secondaryHeaderColor.withOpacity(.1),
      ),
      child: Icon(
        icon,
        color: Theme.of(context).secondaryHeaderColor,
        size: 12,
      ),
    );
  }

  Widget _buildInvoiceProductList(
    BuildContext context,
  ) =>
      MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.model.allProducts.length,
          itemBuilder: (context, index) {
            final Product product = widget.model.allProducts[index];
            return Container(
              padding: const EdgeInsets.only(
                top: 15,
                left: 22,
                right: 10,
                bottom: 14,
              ),
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? Colors.transparent
                    : const Color(0x0d5F5F5F),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${index + 1}. ${product.title}',
                        style: const TextStyle(
                          fontFamily: 'Euclid Circular A',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          '${product.price} XAF',
                          style: const TextStyle(
                            fontFamily: 'Euclid Circular A',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 11),
                  product.promo != null
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0x1a93BF15),
                            borderRadius: BorderRadius.circular(5.63),
                          ),
                          child: Text(
                            product.promo!,
                            style: const TextStyle(
                              fontFamily: 'Euclid Circular A',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff5B7B00),
                            ),
                          ),
                        )
                      : Container(),
                  Expanded(child: Container()),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildButton(context, Icons.remove, () {}),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          0.toString(),
                          style: const TextStyle(
                            fontFamily: 'Euclid Circular A',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      _buildButton(context, Icons.add, () {}),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );

  Widget _buildInvoiceForm(
    BuildContext context,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildClientSearchField(context),
          const SizedBox(height: 8),
          _buildProductSearchField(context),
          const SizedBox(height: 4),
          _buildInvoiceProductList(context),
        ],
      );

  Widget _buildInvoiceList(
    BuildContext context,
  ) =>
      MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.model.allInvoices.length,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
            child: UIInvoiceBlock(widget.model.allInvoices[index]),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 115),
        child: Column(
          children: [
            UIHeader(
              title: 'Manage Invoice',
              subtitle: 'Create customer invoices and complete payment',
              actionText: 'New Invoice',
              actionIcon: Icons.add,
              actionPressed: () => Navigator.of(context).pushNamed('/payment'),
            ),
            const SizedBox(height: 26),
            const UISectionTitle(
              title: 'Create New Invoice',
              subtitle: 'Fill the blank spaces',
            ),
            const SizedBox(height: 34),
            Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: _buildInvoiceForm(context),
            ),
            const SizedBox(height: 34),
            const UISectionTitle(
              title: 'Invoice list',
              subtitle: 'Your invoice list',
              addon: UISearchInput(),
            ),
            const SizedBox(height: 34),
            Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: _buildInvoiceList(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const UIBottomNavigationBar(),
    );
  }
}
