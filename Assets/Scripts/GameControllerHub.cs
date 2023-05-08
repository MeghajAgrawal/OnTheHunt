using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
public class GameControllerHub : MonoBehaviour
{
    // Start is called before the first frame update
    public TextMeshProUGUI coins;
    public string playercoins = "playercoins";
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Ink.Runtime.Object value =  DialogueManager.GetInstance().GetVariableState(playercoins);
        coins.text = value.ToString();
    }
    
}
