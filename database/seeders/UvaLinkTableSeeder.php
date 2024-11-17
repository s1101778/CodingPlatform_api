<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Log;
use Exception; // 確保可以捕捉異常

class UvaLinkTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $sqlFilePath = base_path('resources\\sql\\UvaLink.sql');
        $outputFilePath = base_path('resources\\sql\\UvaCode.sql');
        $codeFileDirectory = base_path('resources\\sql\\codes\\'); // C++ 檔案所在目錄


        function readFileContent($filePath)
        {
            if (file_exists($filePath)) {
                return file_get_contents($filePath);
            } else {
                throw new Exception("文件未找到: $filePath");
            }
        }

        // 解析 C++ 文件内容的函数
        function parseCppFileContent($content)
        {
            $blocks = [];

            // 使用正则表达式解析内容
            $pattern = '/---(\w+)---\s*(.*?)\s*(?=---\w+---|$)/s';
            preg_match_all($pattern, $content, $matches, PREG_SET_ORDER);

            foreach ($matches as $match) {
                $blockName = $match[1];
                $blockContent = $match[2];
                $blocks[$blockName] = $blockContent;
            }

            return $blocks;
        }

        // 定義一個函數來處理可能的 NULL 值
        function formatValue($value, bool $flag)
        {
            if ($flag) {
                return $value === NULL ? "'" . '如果看到這行就表示未考過此題' . "'" : "'" . $value . "'";
            }
            return $value === NULL ? "'" . '如果看到這行就表示沒有此測資' . "'" : "'" . $value . "'";
        }


        try {
            // 读取 SQL 文件内容
            $sqlContent = readFileContent($sqlFilePath);

            // 匹配每条 INSERT 语句并提取数据
            preg_match_all(
                "/VALUES \((\d+), (\d+), ('[^']*'), ('[^']*'), ('[^']*'), (\d+), (NULL|'[^']*'), (NULL|'[^']*'), (NULL|'[^']*'), (NULL|'[^']*')\);/m",
                $sqlContent,
                $matches,
                PREG_SET_ORDER
            );


            $updatedSqlContent = ''; // 初始化為空字符串

            foreach ($matches as $match) {

                $id = $match[1];
                $serial = $match[2];
                $title = $match[3];
                $show = $match[4];
                $topic_url = $match[5];
                $star = $match[6];


                // 根据 serial 编号生成 txt 文件路径
                $cppFilePath = $codeFileDirectory . $serial . '.txt';

                if (file_exists($cppFilePath)) {
                    // 读取 txt 文件内容
                    $cppFileContent = readFileContent($cppFilePath);
                    $parsedContent = parseCppFileContent($cppFileContent);

                    $codeContent = isset($parsedContent['code']) ? addslashes($parsedContent['code']) : NULL;
                    $dataInputContent = isset($parsedContent['dataInput']) ? addslashes($parsedContent['dataInput']) : NULL;
                    $dataOutputContent = isset($parsedContent['dataOutput']) ? addslashes($parsedContent['dataOutput']) : NULL;
                    $dataAInputContent = isset($parsedContent['dataAInput']) ? addslashes($parsedContent['dataAInput']) : NULL;
                    $dataAOutputContent = isset($parsedContent['dataAOutput']) ? addslashes($parsedContent['dataAOutput']) : NULL;
                    $dataBInputContent = isset($parsedContent['dataBInput']) ? addslashes($parsedContent['dataBInput']) : NULL;
                    $dataBOutputContent = isset($parsedContent['dataBOutput']) ? addslashes($parsedContent['dataBOutput']) : NULL;
                } else {
                    $codeContent = NULL; // 如果文件不存在，则设为 NULL
                    $dataInputContent = NULL;
                    $dataOutputContent = NULL;
                    $dataAInputContent = NULL;
                    $dataAOutputContent = NULL;
                    $dataBInputContent = NULL;
                    $dataBOutputContent = NULL;
                }


                // 生成更新后的 SQL 语句
                $updatedSqlContent .= sprintf(
                    "INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (%d, %d, %s, %s, %s, %d, %s, %s, %s, %s, %s, %s, %s);\n",
                    $id,
                    $serial,
                    $title,
                    $show,
                    $topic_url,
                    $star,
                    formatValue($codeContent, true),
                    formatValue($dataInputContent, false),
                    formatValue($dataOutputContent, false),
                    formatValue($dataAInputContent, false),
                    formatValue($dataAOutputContent, false),
                    formatValue($dataBInputContent, false),
                    formatValue($dataBOutputContent, false)
                );
            }

            // 将更新后的 SQL 写入新文件
            file_put_contents($outputFilePath, $updatedSqlContent);
            echo "SQL 文件已更新: $outputFilePath\n";
        } catch (Exception $e) {
            echo "错误: " . $e->getMessage() . "\n";
        }
    }
}