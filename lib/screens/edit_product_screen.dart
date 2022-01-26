import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:relax_shop/models/product.dart';

class EditProuductScreen extends StatefulWidget {
  const EditProuductScreen({Key? key}) : super(key: key);

  static const routName = "/edit-product";

  @override
  _EditProuductScreenState createState() => _EditProuductScreenState();
}

class _EditProuductScreenState extends State<EditProuductScreen> {
  final _form = GlobalKey<FormState>();

  var _product = Product(
    id: '',
    title: '',
    imageUrl: '',
    argument: '',
    price: 0.0,
    isNew: false,
    sale: 0,
    backgroundcolor: Colors.amber,
  );

  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _saleFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _saleFocus.dispose();
  }

  Color _selectedColor = Colors.amber;
  Color _pickerColor = Colors.amber;

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Rasm linkini kiriting!'),
          content: Form(
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Rasm URL',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
              onSaved: (newValue) {
                _product = Product(
                  id: _product.id,
                  title: _product.title,
                  imageUrl: newValue!,
                  argument: _product.argument,
                  price: _product.price,
                  isNew: _product.isNew,
                  sale: _product.sale,
                  backgroundcolor: _product.backgroundcolor,
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('BEKOR QILISH'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('SAQLASH'),
            ),
          ],
        );
      },
    );
  }

  void _saveForm() {
    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Mahsulotni qo'shish"),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nomi',
                    border: OutlineInputBorder(),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                  onSaved: (newValue) {
                    _product = Product(
                      id: _product.id,
                      title: newValue!,
                      imageUrl: _product.imageUrl,
                      argument: _product.argument,
                      price: _product.price,
                      isNew: _product.isNew,
                      sale: _product.sale,
                      backgroundcolor: _product.backgroundcolor,
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Qo\'shimcha ma\'lumot',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 5,
                  focusNode: _descriptionFocus,
                  keyboardType: TextInputType.multiline,
                  onSaved: (newValue) {
                    _product = Product(
                      id: _product.id,
                      title: _product.title,
                      imageUrl: _product.imageUrl,
                      argument: newValue!,
                      price: _product.price,
                      isNew: _product.isNew,
                      sale: _product.sale,
                      backgroundcolor: _product.backgroundcolor,
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Narxi',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocus,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_saleFocus);
                  },
                  onSaved: (newValue) {
                    _product = Product(
                      id: _product.id,
                      title: _product.title,
                      imageUrl: _product.imageUrl,
                      argument: _product.argument,
                      price: double.parse(newValue!),
                      isNew: _product.isNew,
                      sale: _product.sale,
                      backgroundcolor: _product.backgroundcolor,
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Chegirma %',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  focusNode: _saleFocus,
                  onSaved: (newValue) {
                    _product = Product(
                      id: _product.id,
                      title: _product.title,
                      imageUrl: _product.imageUrl,
                      argument: _product.argument,
                      price: _product.price,
                      isNew: _product.isNew,
                      sale: int.parse(newValue!),
                      backgroundcolor: _product.backgroundcolor,
                    );
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Mahsulot yangimi: '),
                    Checkbox(
                      value: _product.isNew,
                      onChanged: (_) {
                        setState(
                          () {
                            _product = Product(
                              id: _product.id,
                              title: _product.title,
                              imageUrl: _product.imageUrl,
                              argument: _product.argument,
                              price: _product.price,
                              isNew: !_product.isNew,
                              sale: _product.sale,
                              backgroundcolor: _product.backgroundcolor,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Orqa fon rangini tanlang:'),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: _pickerColor,
                                  onColorChanged: (Color color) {
                                    setState(() => _pickerColor = color);
                                  },
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        _selectedColor = _pickerColor;
                                        _product = Product(
                                          id: _product.id,
                                          title: _product.title,
                                          imageUrl: _product.imageUrl,
                                          argument: _product.argument,
                                          price: _product.price,
                                          isNew: _product.isNew,
                                          sale: _product.sale,
                                          backgroundcolor: _selectedColor,
                                        );
                                      },
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Tayyor',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          color: _product.backgroundcolor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Card(
                  margin: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => _showImageDialog(context),
                    splashColor:
                        Theme.of(context).primaryColor.withOpacity(0.5),
                    highlightColor: Colors.transparent,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text(
                          'Asosiy rasm linkini qo\'ying (png formatda)!'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
