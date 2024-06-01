using UnityEngine;
using UnityEngine.Networking;
using System.Collections;

public class ScriptLoader : MonoBehaviour
{
    public string scriptUrl = "https://raw.githubusercontent.com/yourusername/yourrepository/main/script.txt";

    void Start()
    {
        StartCoroutine(DownloadAndExecuteScript());
    }

    IEnumerator DownloadAndExecuteScript()
    {
        UnityWebRequest www = UnityWebRequest.Get(scriptUrl);
        yield return www.SendWebRequest();

        if (www.result != UnityWebRequest.Result.Success)
        {
            Debug.LogError("Error downloading script: " + www.error);
        }
        else
        {
            string scriptContent = www.downloadHandler.text;
            ExecuteScript(scriptContent);
        }
    }

    void ExecuteScript(string scriptContent)
    {
        // Simple example: applying downloaded settings
        // In reality, you'd need a way to parse and execute script content securely
        if (scriptContent.Contains("SetFallThreshold"))
        {
            float threshold = float.Parse(scriptContent.Split('=')[1]);
            GetComponent<PlayerController>().fallThreshold = threshold;
        }
    }
}
