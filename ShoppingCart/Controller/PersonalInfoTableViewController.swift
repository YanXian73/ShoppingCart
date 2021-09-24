//
//  PersonalInfoTableViewController.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2021/9/24.
//

import UIKit

class PersonalInfoTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

     var infoImage = UIImage(systemName: "camera")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 162
        }
        return 73
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath) as! PersonalInfoTableViewCell
            cell.photoImageView.image = infoImage
            cell.photoImageView.layer.cornerRadius = 30
//            cell.photoImageView.clipsToBounds = true
//            cell.photoImageView.layer.masksToBounds = true
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! PersonalInfoTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! PersonalInfoTableViewCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! PersonalInfoTableViewCell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath) as! PersonalInfoTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell5", for: indexPath) as! PersonalInfoTableViewCell
            return cell
        }
       
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            let alert = UIAlertController(title: "Path", message: "", preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.dismiss(animated: true)
                pickerController.sourceType = .camera
                self.present(pickerController, animated: true)
            }
            let savePhotosAlbum = UIAlertAction(title: "PhotosAlbum", style: .default) { _ in
                self.dismiss(animated: true, completion: nil)
                pickerController.sourceType = .savedPhotosAlbum
                self.present(pickerController, animated: true, completion: nil)
            }
            alert.addAction(camera)
            alert.addAction(savePhotosAlbum)
            present(alert, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.infoImage = image // .....
            self.dismiss(animated: true)
            self.tableView.reloadData()
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
