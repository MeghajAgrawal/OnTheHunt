using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class INKVariables : MonoBehaviour
{
    // Start is called before the first frame update
    public string namefor;
    public string quantity;

    public string namevalue;
    public string namequanity;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        namefor = DialogueManager.GetInstance().GetVariableState(namevalue).ToString();
        quantity = DialogueManager.GetInstance().GetVariableState(namequanity).ToString();
        Debug.Log("Item Collected: "+namefor+" Item Quantity: "+quantity);
    }
}
